--  To run: alr run


with Ada.Text_IO;
use Ada.Text_IO;
with Util.Http.Clients;
with Util.Http.Clients.Curl;
with GNATCOLL.JSON;

procedure Flight_Monitor is
   
   type Aircraft is record
      ICAO24        : String (1 .. 6); --  Unique aircraft identifier
      Callsign      : String (1 .. 6);  -- Flight Number
      Velocity      : Float; -- Velocity of aircraft (m/s)
      True_Track    : Float; --  Direction of aircraft
      Latitude      : Float; -- X axis position of aircraft
      Longitude     : Float; -- Y axis postion of aircraft
      Baro_Altitude : Float; -- flight altitude of aircraft (m)
   end record;
   plane_1 : Aircraft :=
     (ICAO24        => "ABC123",
      Callsign      => "BAW123",
      Velocity      => 500.0,
      True_Track    => 200.0,
      Latitude      => 45.4,
      Longitude     => 33.3,
      Baro_Altitude => 6000.0);

   
   begin
      --  Register HTTP
      Util.Http.Clients.Curl.Register;

      declare
      Http           : Util.Http.Clients.Client;
      Response       : Util.Http.Clients.Response;
      Data           : GNATCOLL.JSON.JSON_Value;
      States         : GNATCOLL.JSON.JSON_Array;
      First_Value    : GNATCOLL.JSON.JSON_Value;
      First_Aircraft : GNATCOLL.JSON.JSON_Array;
      ICAO24         : GNATCOLL.JSON.JSON_Value;
      Callsign       : GNATCOLL.JSON.JSON_Value;
      Velocity       : GNATCOLL.JSON.JSON_Value;
      True_Track     : GNATCOLL.JSON.JSON_Value;
      Latitude       : GNATCOLL.JSON.JSON_Value;
      Longitude      : GNATCOLL.JSON.JSON_Value;
      Baro_Altitude  : GNATCOLL.JSON.JSON_Value;

      begin
         Put_Line ("Sending OpenSky request...");

         Http.Get
            ("https://opensky-network.org/api/states/all", Response);

         Put_Line ("Request Completed ");

         --  Parse the JSON Response
         Data := GNATCOLL.JSON.Read (Response.Get_Body);

         --  Retrieve the states in array
         States := GNATCOLL.JSON.Get (Data, "states");

         --  Number of aircrafts returned
         Put_Line 
            ("Aircraft returned:" &
            Natural'Image (GNATCOLL.JSON.Length (States)));

         --  HTTP Response status
         Ada.Text_IO.Put_Line
            ("HTTP Status:" & Natural'Image (Response.Get_Status));

         --  Retrieve the first aircraft
         if GNATCOLL.JSON.Length (States) > 0 then
            -- Gets first aircraft
            First_Value    := GNATCOLL.JSON.Get (States, 1);

            -- Convert it into an array of fields
            First_Aircraft := GNATCOLL.JSON.Get (First_Value);

            -- Retrieve all data from first State Array
            ICAO24         := GNATCOLL.JSON.Get (First_Aircraft, 1);
            Callsign       := GNATCOLL.JSON.Get (First_Aircraft, 2);
            Velocity       := GNATCOLL.JSON.Get (First_Aircraft, 10);
            True_Track     := GNATCOLL.JSON.Get (First_Aircraft, 11);
            Latitude       := GNATCOLL.JSON.Get (First_Aircraft, 6);
            Longitude      := GNATCOLL.JSON.Get (First_Aircraft, 6);
            Baro_Altitude  := GNATCOLL.JSON.Get (First_Aircraft, 8);

            Put_Line("ICAO24:"         & GNATCOLL.JSON.Get (ICAO24));
            Put_Line("Callsign:"       & GNATCOLL.JSON.Get (Callsign));
            Put_Line("Velocity:"       & Float'Image (GNATCOLL.JSON.Get(Velocity)));
            Put_Line("True Track:"     & Float'Image (GNATCOLL.JSON.Get (True_Track)));
            Put_Line("Latitude:"       & Float'Image (GNATCOLL.JSON.Get (Latitude)));
            Put_Line("Longitude:"      & Float'Image (GNATCOLL.JSON.Get (Longitude)));
            Put_Line("Baro Altitude:"  & Float'Image (GNATCOLL.JSON.Get (Baro_Altitude)));
         end if;

      end;
end Flight_Monitor;