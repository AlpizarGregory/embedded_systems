import { useNavigate } from "react-router-dom";
import { useContext, useState } from "react";
//import { UserContext } from "../contexts/UserContext";

function Login() {
  const navigate = useNavigate();
  //const { setCurrentUser } = useContext(UserContext);
  const [loginCredentials, setLoginCredentials] = useState({
    email: "",
    password: "",
  });

  const handleSubmit = async (e) => {
    e.preventDefault();
    //createTask({title,description});
    //setTitle("")
    //setUsername(user)
    //navigate("/home")

    try {
      const res = await fetch("http://localhost:5000/api/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(loginCredentials),
      });

      const data = await res.json();

      if (!res.ok) {
        alert(data.error || "Error al iniciar sesión");
        return;
      }

      // Guardar usuario en contexto
      setCurrentUser({
        firstname: data.user.firstname,
        lastname: data.user.lastname,
        email: data.user.email,
      });

      alert("Bienvenido " + data.user.firstname);
      //navigate("/home"); // O la ruta principal de la app
    } catch (err) {
      console.error(err);
      alert("Error de conexión con el servidor");
    }
  };

  return (
    <div className="bg-gradient-to-b from-blue-900 via-purple-900 to-pink-900 grid items-center w-screen h-screen">
      <form className="text-2xl -mt-20 font-mono text-center" onSubmit={handleSubmit}>
        <h1 className="text-white text-2xl mb-5">Welcome, type your respective <br/> credentials to log in.</h1>
        <h3 className="text-white mb-3">Email</h3>
        <input className="mb-5 bg-white rounded-md p-1 text-black"
          type="email"
          placeholder=""
          required
          onChange={(e) => {
            setLoginCredentials({ ...loginCredentials, email: e.target.value });
          }}
        ></input>
        <h3 className="mb-3 text-white">Password</h3>
        <input className="mb-5 bg-white rounded-md p-1 text-black"
          type="password"
          required
          placeholder=""
          onChange={(e) => {
            setLoginCredentials({
              ...loginCredentials,
              password: e.target.value,
            });
          }}
        ></input>
        <br></br>
        <button className="text-white bg-transparent border-2 rounded-md p-2 w-40 hover:bg-blue-950/40">Log In</button>
      </form>
    </div>
  );
}

export default Login;
