------------------------------------------------------------------------------------------------*	
-- Nom du projet	:	Gestion des routeurs avec cache.				|
-- Promotion 		:	2022/2023							|
-- Auteurs 		: 	BOUCHAMA Ayoub ** ElGUERRAOUI Oussama ** MARZOUGUI Achraf	|
-- Encadrant		:	MENDIL Ismail							|
-- Code			:	Test du module LC 						|
------------------------------------------------------------------------------------------------*	

with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Exceptions; 		use Exceptions;
with LC;

procedure Test_LC is
  package LCA_String_Integer is
    new LC (T_Cle => String, T_Donnee => Integer);
  use LCA_String_Integer;

  -- Initialiser l'annuaire vide.
  procedure Construire_Annuaire_Vide (Annuaire : out T_LCA) is
  begin
    Initialiser (Annuaire);
  end Construire_Annuaire_Vide;

  -- Afficher la Sda.
  procedure Afficher (Annuaire : T_LCA) is
  begin
    if Est_Vide (Annuaire) then
      Put_Line ("Annuaire vide");
    else
      Put (Annuaire.All.Cle & " : " & Integer'Image (Annuaire.All.Donnee));
      New_Line;
      Afficher (Annuaire.All.Suivant);
    end if;
  end Afficher;

begin
  declare
    Annuaire : T_LCA;
  begin
    -- Tester Initialiser et Est_Vide
    Construire_Annuaire_Vide (Annuaire);
    pragma Assert (Est_Vide (Annuaire));

    -- Tester Enregistrer et Taille
    Enregistrer (Annuaire, "Cle 1", 10);
    pragma Assert (not Est_Vide (Annuaire));
    pragma Assert (Taille (Annuaire) = 1);

    -- Tester Cle_Presente et La_Donnee
    pragma Assert (Cle_Presente (Annuaire, "Cle 1"));
    pragma Assert (La_Donnee (Annuaire, "Cle 1") = 10);

    -- Tester Supprimer
    Supprimer (Annuaire, "Cle 1");
    pragma Assert (Est_Vide (Annuaire));
    pragma Assert (Taille (Annuaire) = 0);

    -- Tester Vider
    Enregistrer (Annuaire, "Cle 1", 10);
    Enregistrer (Annuaire, "Cle 2", 20);
    Vider (Annuaire);
        -- Tester Enregistrer_Fin
    Enregistrer_Fin (Annuaire, "Cle 3", 30);
    Enregistrer_Fin (Annuaire, "Cle 4", 40);
    Afficher (Annuaire);

    -- Tester Suppression_Haute
    Suppression_Haute (Annuaire);
    Afficher (Annuaire);
  end;
end Test_LC;
