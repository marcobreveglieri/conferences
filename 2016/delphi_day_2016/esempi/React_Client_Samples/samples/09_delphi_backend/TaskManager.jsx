var TaskManager = React.createClass({

    render: function () {
        return (
            <div>
                <TaskInsert endpointUrl={this.props.endpointUrl}/>
                <TaskList endpointUrl={this.props.endpointUrl}/>
            </div>
        );
    }

});
