const express = require('express');
const app = express();

const porta = 3000;

const cors = require('cors');
app.use(cors());

const path = require('path');


app.use('/imgs', express.static(path.join(__dirname, 'imgs')));


// vetor com as informações dos monitores
const monitores = [

  {
    id: 1,
    nome: "Grabalos",
    imagem: "http://localhost:3000/imgs/homemAvatar.png",
    horarios: [
      { dia: "Segunda-feira", horario: "07:30 - 12:15" },
      { dia: "Terça-feira", horario: "07:30 - 09:45" },
      { dia: "Quarta-feira", horario: "07:30 - 08:15 | 18:15 - 21:15" },
      { dia: "Sexta-feira", horario: "07:30 - 09:00"}
    ]
  },

  {
    id: 2,
    nome: "Beatriz",
    imagem: "http://localhost:3000/imgs/mulherAvatar.png",
    horarios: [

      { dia: "Segunda-feira", horario: "07:30 - 13:00" },
      { dia: "Terça-feira", horario: "07:30 - 09:45" },
      { dia: "Quarta-feira", horario: "17:30 - 18:15" },
      { dia: "Sexta-feira", horario: "07:30 - 09:00 | 12:15 - 14:15"}
    ]
  },
  
  {
    id: 3,
    nome: "Marcos",
    imagem: "http://localhost:3000/imgs/homemAvatar.png",
    horarios: [

        { dia: "Segunda-feira", horario: "08:15 - 12:15 | 18:15 - 19:00" },
        { dia: "Terça-feira", horario: "07:30 - 09:45 | 18:15 - 19:00" },
        { dia: "Quarta-feira", horario: "17:30 - 19:00" },
        { dia: "Sexta-feira", horario: "08:15 - 09:00 | 13:30 - 14:15"},
        { dia: "Sábado", horario: "10:00 - 12:15"}
    ]
  },

  {
    id: 4,
    nome: "Anna",
    imagem: "http://localhost:3000/imgs/mulherAvatar.png",
    horarios: [

        { dia: "Segunda-feira", horario: "13:30 - 14:15" },
        { dia: "Terça-feira", horario: "08:15 - 12:15" },
        { dia: "Quarta-feira", horario: "08:15 - 12:15" },
        { dia: "Quinta-feira", horario: "13:30 - 14:15"},
        { dia: "Sexta-feira", horario: "16:45 - 17:30"}
    ]
  },

  {
    id: 5,
    nome: "Ricardo",
    imagem: "http://localhost:3000/imgs/homemAvatar.png",
    horarios: [

        { dia: "Terça-feira", horario: "19:00 - 19:45" },
        { dia: "Quarta-feira", horario: "20:30 - 23:00" },
        { dia: "Quinta-feira", horario: "15:00 - 16:45 | 21:30 - 23:00"},
        { dia: "Sexta-feira", horario: "14:15 - 16:45 | 20:30 - 23:00"},
        { dia: "Sábado", horario: "07:30 - 08:15"}
    ]
  }
];

// Rota para retornar a lista de monitores
app.get('/monitores', (req, res) => {
  res.json(monitores);
});

// Rota para retornar um monitor específico
app.get('/monitores/:id', (req, res) => {

  const monitorId = parseInt(req.params.id);
  const monitor = monitores.find(m => m.id === monitorId);

  if (monitor) {

    res.json(monitor);

  } 

  else {

    res.status(404).json({ error: 'Monitor não encontrado' });
    
  }
});

app.listen(porta, () => {
  console.log(`API rodando em http://localhost:${porta}`);
});
