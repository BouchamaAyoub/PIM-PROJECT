------------------------------------------------------------------------------------------------*	
-- Nom du projet	:	Gestion des routeurs avec cache.
-- Promotion 		:	2022/2023
-- Auteurs 		: 	BOUCHAMA Ayoub
-- Encadrant		:	MENDIL Ismail
-- Code			:	Implantation du module IP_ADRESS
------------------------------------------------------------------------------------------------*	

with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Exceptions;           use Exceptions;

package body IP_ADRESS is

    procedure Show_IP (IP : T_Adresse_IP) is 
    begin
      for i in 0..2 loop
        Put(Natural (IP/256**(3-i) mod 256), 1);
        Put(".");
      end loop;
      put(Natural (IP mod 256), 1);
      Put(" ");
    end Show_IP;


    procedure Add_IP (File : in out File_Type ; IP :   T_Adresse_IP) is
    begin
      for i in 0..2 loop
        Put(File, Natural (IP / 256**(3-i) mod 256), 1);
        Put(File, ".");
      end loop;
      put(File, Natural (IP mod 256), 1);
      Put(File, " ");
    end Add_IP;


   function Get_IP(File : in out File_Type) return T_Adresse_IP is
      n : Integer;
      Lien : Character;
      IP : T_Adresse_IP := 0;
    begin
      for i in 0..3 loop
        Get(File, n);
        IP :=  T_Adresse_IP(n) + IP*256;
        if i < 3 then
          Get(File, Lien);
          if Lien /= '.' then
            Put_Line("Syntax Error In IP Adress. Must Be '.' !");
          end if;
        end if;
      end loop;
      return IP;
    end Get_IP;

end IP_ADRESS;
