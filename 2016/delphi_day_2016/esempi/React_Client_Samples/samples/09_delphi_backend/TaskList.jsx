var TaskList = React.createClass({

    getInitialState: function () {
        return { items: [] };
    },

    componentDidMount: function () {
        var self = this;
        $.ajax(this.props.endpointUrl, {
            method: "GET",
            dataType: "json"
        }).success(function (data) {
            console.log(data);
            self.setState({ items: data["result"][0] });
        });
    },

    render: function () {
        return (
            <ul>
                {
                    this.state.items.map(function (item) {
                        return <li key={item}>{item}</li>;
                    })
                }
            </ul>
        );
    }

});
