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

const { execFile } = require("child_process"); // 👈 


// Ruta de prueba
app.get("/", (req, res) => {
  res.send("Server working with SQLite 🚀");
});

// Signup
app.post("/api/signup", async (req, res) => {
  try {
    const { email, firstname, lastname, password, birthday } = req.body;
    if (!email || !password)
      return res.status(400).json({ error: "Email and password are required" });

    db.get("SELECT * FROM users WHERE email = ?", [email], async (err, row) => {
      if (err) return res.status(500).json({ error: "Error DB" });
      if (row)
        return res.status(400).json({ error: "Email is already used." });

      const hashed = await bcrypt.hash(password, 10);
      db.run(
        "INSERT INTO users (email, firstname, lastname, password, birthday) VALUES (?, ?, ?, ?, ?)",
        [email, firstname, lastname, hashed, birthday],
        function (err) {
          if (err)
            return res.status(500).json({ error: "Error saving user" });
          res
            .status(201)
            .json({
              message: "User created succesfully",
              userId: this.lastID,
            });
        }
      );
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Internal Error" });
  }
});

// Login
app.post("/api/login", (req, res) => {
  const { email, password } = req.body;
  if (!email || !password)
    return res.status(400).json({ error: "Email and password are needed" });

  db.get("SELECT * FROM users WHERE email = ?", [email], async (err, user) => {
    if (err) return res.status(500).json({ error: "Error DB" });
    if (!user) return res.status(400).json({ error: "Invalid Credentials" });

    const ok = await bcrypt.compare(password, user.password);
    if (!ok) return res.status(400).json({ error: "Invalid Credentials" });

    const token = jwt.sign({ id: user.id, email: user.email }, JWT_SECRET, {
      expiresIn: "7d",
    });
    res.json({
      message: "Auth Succeded",
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
  console.log(`Server running in http://localhost:${PORT}`)
);

const NodeWebcam = require("node-webcam");

// webcam config
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

// Endpoint for simulated video streaming
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

      setImmediate(sendFrame); 
    });
  };

  sendFrame();
});

// Car full status on memory
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

// Move the car
app.post("/car/move", (req, res) => {
  const { direction, speed } = req.body;

  carState.moving = true;
  carState.direction = direction;
  carState.speed = speed;

  // Turn on lights with the movement
  if (direction === "up") {
    carState.lights.front = true;
  } else if (direction === "down") {
    carState.lights.rear = true;
  } else if (direction === "left") {
    carState.lights.left = true;
  } else if (direction === "right") {
    carState.lights.right = true;
  }

  // 👇 
  execFile("./test_move", [direction, String(speed)], (error, stdout, stderr) => {
    if (error) {
      console.error("Error executing C program:", error);
    }
    if (stderr) {
      console.error("stderr:", stderr);
    }
    if (stdout) {
      console.log("C program output:", stdout);
    }
  });

  res.json({ status: "ok", carState });
});

// Stop the car
app.post("/car/stop", (req, res) => {
  carState.moving = false;
  carState.direction = null;
  carState.speed = 0;

  
  carState.lights.front = false;
  carState.lights.rear = false;
  carState.lights.left = false;
  carState.lights.right = false;

  res.json({ status: "ok", carState });
});

// Turn on/off lights
app.post("/car/lights", (req, res) => {
  const { type, action } = req.body; // type = "front"/"rear"/"left"/"right", action = "on"/"off"

  if (carState.lights.hasOwnProperty(type)) {
    carState.lights[type] = action === "on";
  }

  res.json({ status: "ok", carState });
});

// Get car status
app.get("/car/status", (req, res) => {
  res.json(carState);
});