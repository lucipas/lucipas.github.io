import { StrictMode, useState } from 'react'
import { createRoot } from 'react-dom/client'
import React from "React";
import { BrowserRouter, Routes, Route } from 'react-router';
import Head from "./components/header.tsx"


createRoot(document.getElementById('root') as HTMLElement).render(
  <StrictMode>
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<>
          In progress
        </>} />
      </Routes>
    </BrowserRouter>
  </StrictMode>,
)
