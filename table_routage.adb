------------------------------------------------------------------------------------------------*	
-- Nom du projet	:	Gestion des routeurs avec cache.				|
-- Promotion 		:	2022/2023							|
-- Auteurs 		: 	BOUCHAMA Ayoub ** ElGUERRAOUI Oussama ** MARZOUGUI Achraf	|
-- Encadrant		:	MENDIL Ismail							|
-- Code			:	Implantation du module TABLE_ROUTAGE 				|
------------------------------------------------------------------------------------------------*	

with Ada.Integer_Text_IO;       use Ada.Integer_Text_IO;


package body TABLE_ROUTAGE is


    procedure Show_Line (Cle : T_Adresse_IP  ; Donnee : T_Donnee) is
    begin
      Show_IP(Cle);
      Show_IP(Donnee.Masque);
      Put(To_String(Donnee.Destination));
      New_Line;
    end Show_Line;

    procedure Show_Table (Table : T_LC ; Line : Integer) is
   	procedure Show_Table_Line is new Pour_Chaque(Traiter => Show_Line);
    begin
      Put("table : (ligne "); put(Line, 1); Put(")");
      New_Line;
      Show_Table_Line(Table);
    end Show_Table;

 

    function Compare_Table(Table : T_LC ; IP : T_Adresse_IP) return Unbounded_String is
      Mask_IP : T_Adresse_IP;
      MasK_Max : T_Adresse_IP := 0;
      Out_Interface : Unbounded_String := To_Unbounded_String("Erreur routage");

      procedure Compare_Line(Cle : T_Adresse_IP ; Donnee : T_Donnee) is
      begin
        Mask_IP := IP and Donnee.Masque;
        if Mask_IP = Cle and Donnee.Masque >= Mask_Max then
          Mask_Max := Donnee.Masque;
          Out_Interface := Donnee.Destination;
        end if;
      end Compare_Line;

      procedure Browse_Table is new Pour_Chaque(Traiter => Compare_Line);

    begin
      Browse_Table(Table);
      return Out_Interface;
    end Compare_Table;


    procedure Initialiser_Table(Table : in out T_LC ; File_Table : in out File_Type ) is
      IP : T_Adresse_IP;
      Mask : T_Adresse_IP;
      Destination : Unbounded_String;
      Line_Table : T_Donnee;
    begin
      Initialiser(Table);
      loop
        IP := Get_IP(File_Table);
        Mask := Get_IP(File_Table);
        Destination := To_Unbounded_String(Get_Line(File_Table));
        Trim(Destination, Both);
        Line_Table := (Mask, Destination);
        Enregistrer(Table, IP, Line_Table);
      exit when End_Of_File(File_Table);
      end loop;
      exception
        when End_Error =>
          Put ("Trop de blanc à la fin du fichier.");
          null;
    end Initialiser_Table;

end TABLE_ROUTAGE;


