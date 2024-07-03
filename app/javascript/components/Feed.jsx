import React from "react";
import { Link } from "react-router-dom";

const Feed = (props) => {
    let routePath = `/?feedId=${props.id}`;

    return (
        <div>
          <Link to={routePath}>{props.url}</Link>
        </div>
    );
};

export default Feed;
