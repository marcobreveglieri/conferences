var CodeEditor = React.createClass({

    render: function () {
        return (
            <div className="panel panel-default">
                <div className="panel-heading">
                    <h2 className="panel-title" style={{ fontWeight: "bold" }}>{this.props.unitName}</h2>
                </div>
                <div className="panel-body">
                    <pre style={{fontSize: "x-large"}}>
                        <span className="keyword">unit</span> Unit1;<br/>
                        <br/>
                        <span className="keyword">interface</span><br/>
                        <br/>
                        <span className="keyword">implementation</span><br/>
                        <br/>
                        <span className="keyword">end</span>.<br/>
                    </pre>
                </div>
                <div className="panel-footer">
                    Row: 1 Col: 1
                </div>
            </div>
        );
    }

});