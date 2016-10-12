var IDE = React.createClass({

    render: function () {

        var menuCommandNames = [
            "File", "Edit", "Search", "View", "Refactor", "Project",
            "Run", "Component", "Tools", "Window", "Help"
        ];

        var menuCommandButtons = menuCommandNames.map(function (commandName) {
            return <button className="btn btn-default">{commandName}</button>
        });

        return (
            <div className="container">
                <header style={{ backgroundColor: "navy", color: "white", padding: "4px" }}>
                    <h1>Delphi IDE :)</h1>
                </header>
                <div className="row">
                    <div className="col-lg-12">
                        {menuCommandButtons}
                    </div>
                </div>
                <div className="row">
                    <div className="col-lg-8">
                        <CodeEditor unitName="Unit1.pas" />
                    </div>
                    <div className="col-lg-4">
                        <ComponentPalette />
                    </div>
                </div>
            </div>
        );
    }

});