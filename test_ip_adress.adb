------------------------------------------------------------------------------------------------*	
-- Nom du projet	:	Gestion des routeurs avec cache.				|
-- Promotion 		:	2022/2023							|
-- Auteurs 		: 	BOUCHAMA Ayoub ** ElGUERRAOUI Oussama ** MARZOUGUI Achraf	|
-- Encadrant		:	MENDIL Ismail							|
-- Code			:	Test du module IP_ADRESS					|
------------------------------------------------------------------------------------------------*	

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with IP_ADRESS; use IP_ADRESS;
with Exceptions; use Exceptions;

procedure Test_IP_Address is

  -- Déclaration des variables
  File_IP : File_Type;
  IP : T_Adresse_IP;
  IP_Text : Unbounded_String;

begin

  -- Test de la fonction Show_IP
  IP := 16842752;
  Show_IP(IP);
  Put_Line("(attendu : 10.0.0.0)");

  -- Test de la fonction Add_IP
  Open(File_IP, Out_File, "ip_test.txt");
  IP := 16842752;
  Add_IP(File_IP, IP);
  Close(File_IP);

  -- Test de la fonction Get_IP
  Open(File_IP, In_File, "ip_test.txt");
  IP := Get_IP(File_IP);
  Close(File_IP);

  -- Vérification de la valeur de retour de Get_IP
  pragma Assert(IP = 16842752, "Erreur de lecture de l'adresse IP");

end Test_IP_Address;

