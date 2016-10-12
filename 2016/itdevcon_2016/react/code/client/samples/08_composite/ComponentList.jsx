var ComponentList = React.createClass({

    render: function () {
        return (
            <div className="list-group">
                {
                    this.props.items.map(function (component) {
                        return <button type="button" className="list-group-item" key={component}>{component}</button>;
                    })
                }
            </div>
        );
    }
    
});