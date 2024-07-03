import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "../components/Home";
import FeedList from "../components/FeedList";

export default (
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/feeds" element={<FeedList />}/>
      </Routes>
    </Router>
);
