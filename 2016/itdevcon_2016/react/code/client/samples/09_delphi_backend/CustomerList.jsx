var CustomerList = React.createClass({

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
            self.setState({ items: data });
        });
    },

    render: function () {
        return (
            <table className="table">
                <thead>
                    <tr>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Age</th>
                    </tr>
                </thead>
                <tbody>
                    {
                        this.state.items.map(function (item) {
                            return <tr key={item.id}>
                                    <td>{item.first_name}</td>
                                    <td>{item.last_name}</td>
                                    <td>{item.age}</td>
                                   </tr>;
                        })
                    }
                </tbody>
            </table>
        );
    }

});
