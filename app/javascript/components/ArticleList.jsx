import React, { useEffect, useState } from "react";
import Article from "./Article";

const ArticleList = () => {
    var [articles, setArticles] = useState([]);

    useEffect(() => {
        fetch("http://127.0.0.1:3000/api/articles")
            .then((response) => {
                return response.json();
            }).then((data) => {
                setArticles(data);
            });
    }, []);

    return (
        <div>
          {articles.map((article) => <Article title={article["title"]} description={article["description"]} url={article["url"]} />)}
        </div>
    );
};

export default ArticleList;
