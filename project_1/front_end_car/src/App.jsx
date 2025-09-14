import Start from './components/Start'
import Login from './components/Login'
import { Routes, Route } from "react-router-dom";
function App() {

  return (
    <>
    
    <Routes>
      <Route path="/" element={<Start />} />
      <Route path="/login" element={<Login />} />
    </Routes>
    
    

    </>
  )
}

export default App