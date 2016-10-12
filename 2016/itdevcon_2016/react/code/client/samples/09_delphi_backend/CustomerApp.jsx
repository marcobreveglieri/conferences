var CustomerApp = React.createClass({

    render: function () {
        return (
            <div>
                <CustomerList endpointUrl={this.props.endpointUrl}/>
            </div>
        );
    }

});
