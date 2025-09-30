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

const NodeWebcam = require("node-webcam");

// Configuración de la webcam
const webcamOpts = {
  width: 640,
  height: 480,
  delay: 0,
  quality: 100,
  output: "jpeg",
  device: false,
  callbackReturn: "buffer",
  verbose: false,
};
const Webcam = NodeWebcam.create(webcamOpts);

// Endpoint para streaming de video simulado
app.get("/video_feed", (req, res) => {
  res.writeHead(200, {
    "Content-Type": "multipart/x-mixed-replace; boundary=frame",
    "Cache-Control": "no-cache",
    Connection: "keep-alive",
  });

  const sendFrame = () => {
    NodeWebcam.capture("frame", webcamOpts, (err, buffer) => {
      if (err) return console.error(err);

      res.write(`--frame\r\n`);
      res.write("Content-Type: image/jpeg\r\n\r\n");
      res.write(buffer);
      res.write("\r\n");

      setImmediate(sendFrame); // llama al siguiente frame tan pronto como termine este
    });
  };

  sendFrame();
});

// Estado del carro en memoria
let carState = {
  moving: false,
  direction: null, // "up", "down", "left", "right"
  speed: 0,
  lights: {
    front: false,
    rear: false,
    left: false,
    right: false
  }
};

// Mover el carro
app.post("/car/move", (req, res) => {
  const { direction, speed } = req.body;

  carState.moving = true;
  carState.direction = direction;
  carState.speed = speed;

  // Encender luces según dirección
  if (direction === "up") {
    carState.lights.front = true;
  } else if (direction === "down") {
    carState.lights.rear = true;
  } else if (direction === "left") {
    carState.lights.left = true;
  } else if (direction === "right") {
    carState.lights.right = true;
  }

  res.json({ status: "ok", carState });
});

// Detener el carro
app.post("/car/stop", (req, res) => {
  carState.moving = false;
  carState.direction = null;
  carState.speed = 0;

  // Apagar luces automáticas (no las manuales)
  carState.lights.front = false;
  carState.lights.rear = false;
  carState.lights.left = false;
  carState.lights.right = false;

  res.json({ status: "ok", carState });
});

// Encender/apagar luces manualmente
app.post("/car/lights", (req, res) => {
  const { type, action } = req.body; // type = "front"/"rear"/"left"/"right", action = "on"/"off"

  if (carState.lights.hasOwnProperty(type)) {
    carState.lights[type] = action === "on";
  }

  res.json({ status: "ok", carState });
});

// Obtener estado del carro
app.get("/car/status", (req, res) => {
  res.json(carState);
});