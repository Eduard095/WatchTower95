-- to run program:
--alr build && .\bin\flight_monitor.exe
-- update its alr run



-- Practice



with Ada.Text_IO;
use Ada.Text_IO;

procedure Flight_monitor is
   A,B : Integer;

   begin
   A := Integer'Value (Ada.Text_IO.Get_Line);
   B := Integer'Value (Ada.Text_IO.Get_Line);

   if A = B then
      Ada.Text_IO.Put_Line( Integer'Image(A) & " is equal to" & Integer'Image(B));
   else 
      Ada.Text_IO.Put_Line (Integer'Image(A) & " is NOT equal to" & Integer'Image(B));
   end if;
end Flight_monitor;