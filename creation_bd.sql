drop table if exists public.prets;
drop table if exists public.livres;
drop table if exists public.bibliotheque;

create table public.bibliotheque (
    id INTEGER primary key,
    nom VARCHAR(100),
    courriel VARCHAR(255),
    cle_api VARCHAR(30),
    password VARCHAR(100)
);

create table public.livres (
	id INTEGER primary key,
	bibliotheque_id INTEGER,
	titre VARCHAR(100),
	auteur VARCHAR(100),
	isbn VARCHAR(20),
	date_ajout DATE,
	disponible BOOLEAN,
	foreign key (bibliotheque_id) references public.bibliotheque(id)
);

create table public.prets (
	id INTEGER primary key,
	livre_id INTEGER,
	emprunteur VARCHAR(100),
	date_retour DATE,
	foreign key (livre_id) references public.livres(id)
);