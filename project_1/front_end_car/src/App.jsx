import Start from './components/Start'
import { Routes, Route } from "react-router-dom";
function App() {

  return (
    <>
    
    <Routes>
      <Route path="/" element={<Start />} />
    </Routes>
    
    

    </>
  )
}

export default App