import React, { useEffect, useState } from "react";
import API_URL from "../config";
import Feed from "./Feed";

const FeedList = () => {
    let [feeds, setFeeds] = useState([]);

    useEffect(() => {
        fetch(`${API_URL}/api/feeds`)
            .then((response) => {
                return response.json();
            }).then((data) => {
                setFeeds(data);
            });
    }, []);

    return (
        <div>
          {
              feeds.map(
                  (feed) => <div key={feed["id"]}>
                              <Feed id={feed["id"]} url={feed["url"]} />
                            </div>
              )
          }
        </div>
    );
};

export default FeedList;

