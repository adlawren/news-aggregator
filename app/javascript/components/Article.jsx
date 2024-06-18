import React from "react";

const Article = (props) => {
    return (
        <div>
          <div>Title: {props.title}</div>
          <div>Description: {props.description}</div>
          <div>URL: <a href={props.url}>{props.url}</a></div>
        </div>
    );
};

export default Article;
