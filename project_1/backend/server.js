require("dotenv").config();
const express = require("express");
const cors = require("cors");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const db = require("./db");

const app = express();
app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 5000;
const JWT_SECRET = process.env.JWT_SECRET || "secret_demo";

// Ruta de prueba
app.get("/", (req, res) => {
  res.send("Servidor funcionando con SQLite 🚀");
});

// Signup
app.post("/api/signup", async (req, res) => {
  try {
    const { email, firstname, lastname, password, birthday } = req.body;
    if (!email || !password)
      return res.status(400).json({ error: "Email y password son requeridos" });

    db.get("SELECT * FROM users WHERE email = ?", [email], async (err, row) => {
      if (err) return res.status(500).json({ error: "Error DB" });
      if (row)
        return res.status(400).json({ error: "El email ya está en uso" });

      const hashed = await bcrypt.hash(password, 10);
      db.run(
        "INSERT INTO users (email, firstname, lastname, password, birthday) VALUES (?, ?, ?, ?, ?)",
        [email, firstname, lastname, hashed, birthday],
        function (err) {
          if (err)
            return res.status(500).json({ error: "Error guardando usuario" });
          res
            .status(201)
            .json({
              message: "Usuario creado correctamente",
              userId: this.lastID,
            });
        }
      );
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Error interno" });
  }
});

// Login
app.post("/api/login", (req, res) => {
  const { email, password } = req.body;
  if (!email || !password)
    return res.status(400).json({ error: "Email y password son requeridos" });

  db.get("SELECT * FROM users WHERE email = ?", [email], async (err, user) => {
    if (err) return res.status(500).json({ error: "Error DB" });
    if (!user) return res.status(400).json({ error: "Credenciales inválidas" });

    const ok = await bcrypt.compare(password, user.password);
    if (!ok) return res.status(400).json({ error: "Credenciales inválidas" });

    const token = jwt.sign({ id: user.id, email: user.email }, JWT_SECRET, {
      expiresIn: "7d",
    });
    res.json({
      message: "Autenticación exitosa",
      token,
      user: {
        id: user.id,
        email: user.email,
        firstname: user.firstname,
        lastname: user.lastname,
        birthday: user.birthday,
      },
    });
  });
});

app.get("/api/users", (req, res) => {
  db.all(
    "SELECT id, email, firstname, lastname, birthday FROM users",
    [],
    (err, rows) => {
      if (err) return res.status(500).json({ error: "Error DB" });
      res.json(rows);
    }
  );
});

app.listen(PORT, () =>
  console.log(`Servidor corriendo en http://localhost:${PORT}`)
);

