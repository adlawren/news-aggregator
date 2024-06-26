import React, { useEffect, useState } from "react";
import Article from "./Article";

// This is set using the "define" argument in the esbuild command, to toggle the API URL between development & production
// See package.json
const API_URL = process.env.REACT_API_URL;

const ArticleList = () => {
    var [articles, setArticles] = useState([]);

    useEffect(() => {
        fetch(`${API_URL}/api/articles`)
            .then((response) => {
                return response.json();
            }).then((data) => {
                setArticles(data);
            });
    }, []);

    function dismissArticle(id) {
        fetch(`${API_URL}/api/articles/${id}`, { method: "DELETE" })
            .then((response) => {
                if (response.ok) {
                    let updatedArticles = articles.filter((article) => article["id"] != id);
                    setArticles(updatedArticles);
                }
            });
    }

    return (
        <div>
          {
              articles.map(
                  (article) => <div key={article["id"]}>
                                 <Article title={article["title"]} description={article["description"]} url={article["url"]} />
                                 <button onClick={() => { dismissArticle(article["id"]); }}>Dismiss</button>
                               </div>
              )
          }
        </div>
    );
};

export default ArticleList;
