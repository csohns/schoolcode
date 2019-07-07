(* 'True' mouse cursor for EGA/VGA displays using C functions written
    by Dave Kirsch.   Turbo Pascal unit by Jim Loos. *)

unit mouse;
interface
const
   (* Bit defines for mouse driver function 12 -- define handler. *)
   MOUSEMOVE     = 1;
   LEFTBPRESS    = 2;
   LEFTBRELEASE  = 4;
   RIGHTBPRESS   = 8;
   RIGHTBRELEASE = 16;

   LEFTBDOWN  = 1;
   RIGHTBDOWN = 2;

   (* Shift states for byte a 0:417h
      bit 7 =1 INSert active
      bit 6 =1 Caps Lock active
      bit 5 =1 Num Lock active
      bit 4 =1 Scroll Lock active
      bit 3 =1 either Alt pressed
      bit 2 =1 either Ctrl pressed
      bit 1 =1 Left Shift pressed
      bit 0 =1 Right Shift pressed
   *)

   SHIFT_RIGHTSHIFT = $01;
   SHIFT_LEFTSHIFT  = $02;
   SHIFT_SHIFT      = $03;   (* Either shift key. *)
   SHIFT_CTRL       = $04;
   SHIFT_ALT        = $08;
   SHIFT_SCROLLLOCK = $10;
   SHIFT_NUMLOCK    = $20;
   SHIFT_CAPSLOCK   = $40;
   SHIFT_INS        = $80;

mouseinstalled: word = 0;    (* zero means that the driver is not installed *)
mousehidden: word = 0;       (* non-zero means that the mouse is hidden *)
mousex: integer = 0;         (* mouse cursor X coordinate; updated by driver *)
mousey: integer = 0;         (* mouse cursor Y coordinate: updated by driver *)

type
(* Mouse information record *)
mouinforec = record
  buttonstat: word;          (* status of mouse buttons (see above) *)
  cx, cy: integer;           (* mouse cursor X and Y coordinates *)
  shiftstate: byte;          (* status of shift, control, and alt keys *)
end;

mouinforecptr = ^mouinforec;

var
M: mouinforecptr;
Minfo: mouinforec;

(* Initialize the mouse routines -- must be called. *)
procedure MOUinit; 

(* Deinitialize the mouse routines -- must be called on shutdown.
   Failure to call it will most likely result in a system crash if the mouse
   is moved. *)
procedure MOUdeinit;

(* Hide the mouse cursor *)
procedure MOUhide; 

(* Hide the mouse cursor if it moves or is in a specific rectangular region
   of the screen. *)
procedure MOUconditionalhide(x1, y1, x2, y2: integer); 

(* Show the mouse cursor *)
procedure MOUshow; 

(* return TRUE if there are events waiting in the buffer. *)
function MOUcheck: boolean; 

(* look at the next event in the buffer, but don't pull it out. *)
procedure MOUpreview(MP: mouinforecptr); 

(* get and remove next event from the buffer. *)
procedure MOUget(MP: mouinforecptr); 

(* return the current status of the mouse buttons (see defines above). *)
function MOUbuttonstatus: word;

(* move mouse cursor to new position *)
procedure MOUmove(X, Y: integer);

(* confine mouse to region of screen *)
procedure MOUconfine(X1, Y1, X2, Y2: integer);

implementation
uses CRT, DOS;
{$L MOUSE.OBJ}

var Points: byte absolute $0000:$0485;

procedure MOUinit; external;
procedure MOUdeinit; external;
procedure MOUhide; external;
procedure MOUconditionalhide(x1, y1, x2, y2: integer); external;
procedure MOUshow; external;
function MOUcheck: boolean; external;
procedure MOUpreview(MP: mouinforecptr); external;
procedure MOUget(MP: mouinforecptr); external;
function MOUbuttonstatus: word; external;

procedure MOUmove(X, Y: integer);
var
  Reg: registers;
begin
   MOUHide;
   mousex := X;
   mousey := Y;
   Reg.CX := pred(X*8);
   Reg.DX := Y * Points;
   Reg.AX := 4;
   intr($33, Reg);
   MOUshow;
end; {procedure MOUmove}

procedure MOUconfine(X1, Y1, X2, Y2: integer);
var Reg: registers;
begin
    Reg.AX := 7;
    Reg.CX := X1 * 8;
    Reg.DX := X2 * 8;
    intr($33, Reg);               (* set horizontal limit *)
    Reg.AX := 8;
    Reg.CX := Y1 * Points;
    Reg.DX := Y2 * Points;
    intr($33, Reg);               (* set vertical limit *)
end;

begin
   M := @Minfo;
end.

