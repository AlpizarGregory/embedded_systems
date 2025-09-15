import Start from './components/Start'
import Login from './components/Login'
import SignUp from './components/SignUp'
import HUD from './components/HUD'
import { Routes, Route } from "react-router-dom";
function App() {

  return (
    <>
    
    <Routes>
      <Route path="/" element={<SignUp />} />
      <Route path="/login" element={<Login />} />
      <Route path="/signup" element={<SignUp />} />
      <Route path="/hud" element={<HUD />} />
    </Routes>
    
    

    </>
  )
}

export default App