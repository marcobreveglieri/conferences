var TaskInsert = React.createClass({

    getInitialState: function () {
        return {
            description: ""
        };
    },

    insertTask: function () {
        var self = this;
        $.ajax(this.props.endpointUrl, {
            data: {
                key: self.state.description,
                description: self.state.description
            },
            method: "PUT"
        }).success(function (data) {
            self.setState({ description: "" });
        });
    },

    updateText: function (event) {
        this.setState({ description: event.target.value});
    },

    render: function () {
        var insertButton;
        if (this.state.description.length > 0)
            insertButton = <button onClick={this.insertTask}>Inserisci</button>;
        else
            insertButton = null;

        return (
            <div>
                <input type="text" onChange={this.updateText} />
                {insertButton}
            </div>
        );
    }

});
