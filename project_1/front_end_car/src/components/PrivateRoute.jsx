// PrivateRoute.jsx
import { Navigate } from "react-router-dom";

function PrivateRoute({ children }) {
  const token = localStorage.getItem("token"); // o cualquier estado de auth
  if (!token) {
    return <Navigate to="/login" replace />; // redirige al login si no hay token
  }
  return children; // si hay token, muestra la página
}

export default PrivateRoute;
