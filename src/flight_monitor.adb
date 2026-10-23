with Ada.Text_IO; use Ada.Text_IO;

procedure Flight_Monitor is
   Altitude : Integer:= -100;
begin 
   Put_Line("Checking aircraft altitude....");

   if Altitude < 0 then
      Put_Line("Invalid altitude");
   elsif Altitude < 5000 then
      Put_Line("Aircraft is at low altitude");
   else
      Put_Line("Aircraft altitude recorded");
   end if;
end Flight_Monitor;