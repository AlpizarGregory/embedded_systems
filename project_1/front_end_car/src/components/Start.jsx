import { useNavigate } from "react-router-dom";
function Start() {
  const navigate = useNavigate()
  
  return (
    <>
      <h3>Welcome to HealthyLogic</h3>
      <h5>Do you already have an account?</h5>
      <button onClick={()=>{navigate("/")}}>Log in</button>
      <button onClick={()=>{navigate("/")}}>Sign up</button>
    </>
  );
}

export default Start;
