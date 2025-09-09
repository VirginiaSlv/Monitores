# Monitores

# 📱 Aplicativo de Monitoria DPD

Este projeto é um aplicativo que apresenta os **monitores do DPD** em um **carrossel de cards**. Cada card exibe um avatar e o nome do monitor. Ao selecionar um monitor, o usuário é direcionado a uma nova tela com os **horários de monitoria semanais** daquele monitor.

---

## 📌 Funcionalidades

- 🎠 Carrossel com todos os monitores cadastrados.
- 🧑‍🏫 Cada card exibe a **foto (avatar)** e o **nome** do monitor.
- 📅 Ao clicar no card, exibe-se uma segunda **view com os horários de monitoria** daquele monitor.
- 🌐 Consumo de dados via **API externa** (pode ser desenvolvida em Node.js, Spring Boot, etc).

---

## 🧰 Tecnologias Utilizadas

### 🎯 Frontend (Aplicativo)

- **Framework sugerido:** React Native, Flutter, ou outro similar.
- **Componentes principais:**
  - Carrossel de cards (ex: `react-native-snap-carousel`, `PageView`, etc).
  - Navegação entre telas/views.
  - Estilização com CSS-in-JS ou nativa.
- **HTTP Client:** Axios, Fetch API ou equivalente.

### 🌐 Backend (API)

- **Opções possíveis:**
  - Node.js com Express
  - Spring Boot (Java)
  - Python (Django REST, FastAPI)
- **Endpoints esperados:**
  - `GET /monitores`: retorna todos os monitores com avatar e nome.
  - `GET /monitores/:id/horarios`: retorna os horários de monitoria daquele monitor durante a semana.

---

## 🔗 Exemplo de Estrutura de Dados

### 🎓 Monitores (`GET /monitores`)

```json
[
  {
    "id": 1,
    "nome": "João Silva",
    "avatarUrl": "https://exemplo.com/imagens/joao.png"
  },
  {
    "id": 2,
    "nome": "Maria Oliveira",
    "avatarUrl": "https://exemplo.com/imagens/maria.png"
  }
]
