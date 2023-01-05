------------------------------------------------------------------------------------------------*	
-- Nom du projet	:	Gestion des routeurs avec cache.				|
-- Promotion 		:	2022/2023							|
-- Auteurs 		: 	BOUCHAMA Ayoub ** ElGUERRAOUI Oussama ** MARZOUGUI Achraf	|
-- Encadrant		:	MENDIL Ismail							|
-- Code			:	Test du module TABLE_ROUTAGE 					|
------------------------------------------------------------------------------------------------*	
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with TABLE_ROUTAGE; use TABLE_ROUTAGE;
with Exceptions; use Exceptions;
with IP_ADRESS; use IP_ADRESS;

procedure Test_Routing is

  -- Déclaration des variables
  Table : T_LC;
  File_Table : File_Type;
  IP : T_Adresse_IP;
  Destination : Unbounded_String;

begin

  -- Initialisation de la table de routage à partir d'un fichier de configuration
  Open(File_Table, In_File, "table_routage_test.txt");
  Initialiser_Table(Table, File_Table);
  Close(File_Table);

  -- Affichage de la table de routage
  Show_Table(Table);

  -- Lecture de l'adresse IP au clavier
  Put("Entrez une adresse IP : ");
  IP := Get_IP(Input);

  -- Appel de la fonction Compare_Table
  Destination := Compare_Table(Table, IP);

  -- Affichage de la destination trouvée
  Put_Line("Destination trouvée : " & Destination);

end Test_Routing;


