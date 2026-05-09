drop table if exists public.prets;
drop table if exists public.livres;
drop table if exists public.bibliotheque;

create table public.bibliotheque (
    id SERIAL primary key,
    nom VARCHAR(100),
    courriel VARCHAR(255),
    cle_api VARCHAR(36) UNIQUE,
    password VARCHAR(100)
);

create table public.livres (
	id SERIAL primary key,
	bibliotheque_id INTEGER,
	titre VARCHAR(100),
	auteur VARCHAR(100),
	isbn VARCHAR(20),
	date_ajout DATE,
	disponible BOOLEAN,
	description VARCHAR(255),
	foreign key (bibliotheque_id) references public.bibliotheque(id)
);

create table public.prets (
	id SERIAL primary key,
	livre_id INTEGER not null,
	emprunteur VARCHAR(100) not null,
	date_debut DATE not null,
	date_retour_prevue DATE not null,
	date_retour DATE,
	status BOOLEAN not null,
	foreign key (livre_id) references public.livres(id)
);

/**********************************************************************/
/***************************** Insertion ******************************/
/**********************************************************************/

/***************** Bibliothèques *****************/
insert into public.bibliotheque (nom, courriel, cle_api, password) values
('Bibliothèque Charles-Édouard-Mailhot', 'bibliotheque@victoriaville.ca', '1234', '$2b$10$BLwmB5bW0RYWCSwZH3/KqeX.YZNWqgJCHh6Bgoz55nSTplxqla3ku'),
('Bibliothèque Alcide-Fleury', 'bibliotheque1@victoriaville.ca', '5678', '$2b$10$Gt/r64XG6alSiNfmK3q9UOXR4Vhllxh9a79SOi9xAs7IEtyBWuPui');

/***************** Livres *****************/
/* Les données des livres proviennent du site : https://biblio.victoriaville.ca/ */
insert into public.livres (bibliotheque_id, titre, auteur, isbn, date_ajout, disponible, description) values
(1, 'Walking dead. 32, La fin du voyage', 'Robert Kirkman', '9782413016816', '2019-01-01', false, '149 pages : principalement des illustrations (certaines en couleur) ; 26 cm'),
(1, 'Raconte-moi Marc-André Fleury', 'Frédéric Daigle', '9782897541675', '2019-02-15', true, null),
(2, 'Raconte-moi Carey Price', 'Jean-François Chaumont', '9782924025949', '2015-03-05', true, '139 pages : illustrations ; 19 cm'),
(2, 'Ne jamais trembler', 'Stephen King', '9782226501875', '2016-03-20', false, null);

/***************** Prêts *****************/
insert into public.prets (livre_id, emprunteur, date_debut, date_retour_prevue, date_retour, status) values
(1, 'Jean Dupont', '2024-04-01', '2024-05-01', '2024-05-01', true),
(1, 'Jean Dupont', '2025-05-01', '2025-06-01', null, false ),
(4, 'Marie Tremblay', '2026-04-02', '2026-05-02', null, false);
