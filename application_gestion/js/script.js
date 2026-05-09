const API_URL = "https://tp-service-web-api-didier-mathieu.onrender.com";

async function creerBibliotheque(event) {
    event.preventDefault();  

    const nom = document.getElementById('nom').value;
    const courrielCreation = document.getElementById('courrielCreation').value;
    const mdpCreation = document.getElementById('mdpCreation').value;

    if (!nom || !courrielCreation || !mdpCreation) {
        alert('Veuillez remplir les champs.');
        return;
    }
    
    try {
        let reponse = await fetch(`${API_URL}/api/utilisateurs`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json;charset=utf-8'
        },
        body: JSON.stringify({ nom, courriel: courrielCreation, password: mdpCreation })
        });
    if (!reponse.ok) {
        console.error('Erreur HTTP:', reponse.status);
        return;
    }
        const resultat = await reponse.json();

        document.getElementById('nom').value = '';
        document.getElementById('courrielCreation').value = '';
        document.getElementById('mdpCreation').value = '';

        alert(`Clé api : "${resultat.cle_api}"`);
    } catch (err) {
            console.error('Erreur réseau:', err);
    }
}

async function recupererCleApi(event) {
    event.preventDefault();  

    const courrielRecup = document.getElementById('courrielRecup').value;
    const mdpRecup = document.getElementById('mdpRecup').value;
    const genererNouvelleCle = document.getElementById('genererCle').checked;

    if (!courrielRecup || !mdpRecup) {
        alert('Veuillez remplir les champs.');
        return;
    }

    let url = `${API_URL}/api/utilisateurs/cle`;

    if (genererNouvelleCle) {
        url += '?nouvelle=1';
    }
    
    try {
        let reponse = await fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json;charset=utf-8'
        },
        body: JSON.stringify({ courriel: courrielRecup, password: mdpRecup })
        });

        console.log(reponse);

    if (!reponse.ok) {
        console.error('Erreur HTTP:', reponse.status);
        alert('Aucun utilisateur trouvé avec ce courriel et mot de passe.')
        return;
    }
        const resultat = await reponse.json();

        document.getElementById('courrielRecup').value = '';
        document.getElementById('mdpRecup').value = '';

        if (genererNouvelleCle) {
            alert(`Nouvelle clé générée : "${resultat.cle_api}"`);
        } else {
            alert(`Clé api : "${resultat.cle_api}"`);
        }
    } catch (err) {
            console.error('Erreur réseau:', err);
    }
}

document.getElementById("formulaire-creation").addEventListener("submit", creerBibliotheque);
document.getElementById("formulaire-recuperation").addEventListener("submit", recupererCleApi);