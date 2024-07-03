import React, { useEffect, useState } from "react";
import API_URL from "../config";
import Article from "./Article";

const ArticleList = (props) => {
    let [articles, setArticles] = useState([]);

    useEffect(() => {
        var url = `${API_URL}/api/articles`;
        if (props.feedId) { // Add feed ID if present
            url = url + `?feed_id=${props.feedId}`;
        }

        fetch(url)
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
