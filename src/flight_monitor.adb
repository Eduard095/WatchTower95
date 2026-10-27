--  To run: alr run


with Ada.Text_IO;

procedure Flight_Monitor is
   --  declare float
   type Float_Access is access all Float;

   -- declare range
   subtype ICAO24_Range is String (1 .. 6);
   type ICAO24_Access is access all ICAO24_Range;

   -- decalre range
   subtype Callsign_Range is String (1 .. 7);
   type Callsign_Access is access all Callsign_Range;

   type Aircraft is record
      ICAO24        : ICAO24_Range   := null; --  Unique aircraft identifier
      Callsign      : Callsign_Range := null;  -- Flight Number
      Velocity      : Float_Access   := null; -- Velocity of aircraft (m/s)
      True_Track    : Float_Access   := null; --  Direction of aircraft
      Latitude      : Float_Access   := null; -- X axis position of aircraft
      Longitude     : Float_Access   := null; -- Y axis postion of aircraft
      Baro_Altitude : Float_Access   := null; -- flight altitude of aircraft (m)
   end record;

   procedure Store
      (Target : in out Aircraft; --  in out means the variable is passed into the procedure, modified inside it and the updated version is passed back out
       Json_Text : in String)
   is
   begin
   
end Flight_Monitor;