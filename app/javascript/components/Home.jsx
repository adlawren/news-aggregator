import React from "react";
import { useLocation } from "react-router-dom";
import ArticleList from "./ArticleList";

const Home = () => {
    let location = useLocation();
    let queryParams = new URLSearchParams(location.search);
    let feedId = queryParams.get("feedId");

    return (
        <ArticleList feedId={feedId} />
    );
};

export default Home;
