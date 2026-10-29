--  To run: alr run


with Ada.Text_IO;
use Ada.Text_IO;
with Util.Http.Clients;
with Util.Http.Clients.Curl;

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
      Http     : Util.Http.Clients.Client;
      Response : Util.Http.Clients.Response;
      begin
         Put_Line ("Sending OpenSky request...");
         Http.Get
            ("https://opensky-network.org/api/states/all", Response);
         Put_Line ("Request Completed ");
         Ada.Text_IO.Put_Line
            ("HTTP Status:" & Natural'Image (Response.Get_Status));

         Ada.Text_IO.Put_Line (Response.Get_Body);
      end;
   Put_Line (Float'Image(plane_1.Latitude));
end Flight_Monitor;