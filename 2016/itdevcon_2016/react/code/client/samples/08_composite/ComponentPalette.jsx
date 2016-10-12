var ComponentPalette = React.createClass({

    filterList: function (event) {
        var filteredList = this.state.allComponents.filter(
            function (item) {
                return item.toLowerCase().search(
                        event.target.value.toLowerCase()) !== -1;
            });
        this.setState({visibleComponents: filteredList});
    },

    getInitialState: function () {
        return {
            allComponents: [
                "TMainMenu",
                "TPopupMenu",
                "TLabel",
                "TEdit",
                "TMemo",
                "TButton",
                "TCheckBox",
                "TRadioButton",
                "TListBox",
                "TComboBox",
                "TScrollBar",
                "TGroupBox",
                "TRadioGroup",
                "TPanel",
                "TActionList"
            ],
            visibleComponents: []
        }
    },

    componentWillMount: function () {
        this.setState({visibleComponents: this.state.allComponents})
    },

    render: function () {
        return (
            <div className="panel panel-default">
                <div className="panel-heading">
                    Component Palette &nbsp;
                    <input type="text" placeholder="Type to filter" onChange={this.filterList}/>
                </div>
                <div className="panel-body">
                    <ComponentList items={this.state.visibleComponents}/>
                </div>
            </div>
        );
    }
});
