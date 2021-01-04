import 'package:flutter/material.dart';
import 'package:myweb/app/shop/controller/searchBloc.dart';
import 'package:myweb/app/shop/model/searchStatus.dart';
import 'package:myweb/framework/app/appPage.dart';
import 'package:myweb/framework/app/appRouters.dart';
import 'package:myweb/framework/core/appBlocBuilder.dart';
import 'package:myweb/framework/core/appBlocProvider.dart';

class SearchPage extends AppPage {
  @override
  Widget build(BuildContext context) {
    AppBlocProvider<SearchBloc> blocProvider = AppBlocProvider<SearchBloc>(
      create: (context) => SearchBloc(),
      child: AppBlocBuilder<SearchBloc,SearchStatus>(
        builder:_buildForm),
    );
    return blocProvider;
  }
}



  Widget _buildForm(BuildContext context,SearchStatus searchStatus) {
    
    return Form(
        child: Column(
      children: [
        _buildCityFormField(context),
        _buildAgentFormField(context),
        _buildChannelFormField(context),
        RaisedButton(
            child: Text('搜索'),
            onPressed: () {
             
              SearchStatus eventState =searchStatus.copy();
              AppBlocProvider.of<SearchBloc>(context).dispatch("submit", eventState);
              AppRouters.router.navigateTo(context, '/search/result');
            
            }),
        RaisedButton(
            child: Text('地图'),
            onPressed: () {
              //SearchStatus eventState = searchStatus.copy();
              AppRouters.router.navigateTo(context, '/map',
                  routeSettings: RouteSettings(
                    arguments: 'p=eventState',
                  ));
              
            }),
      ],
    ));
  }

  Widget _buildCityFormField(BuildContext context) {
    String labelText = '区域';
    Function onValidator = (String value) {
      return true;
    };
    Function onSaved = (String value) {};
    return _buildFormTextField(context, labelText, onValidator, onSaved);
  }

  Widget _buildAgentFormField(BuildContext context) {
    Function onValidator = (String value) {
      return true;
    };
    Function onSaved = (String value) {};
    return _buildFormRadioField(context, onValidator, onSaved);
  }

  Widget _buildChannelFormField(BuildContext context) {
    // Function onChanged = (String value) {};
    return _buildDropdownButtonField(context, onChannelChanged);
  }

  void onChannelChanged(dynamic value) {
     
  }

  Widget _buildFormTextField(BuildContext context, String labelText,
      Function onValidator, Function onSaved) {
    return LimitedBox(
        maxWidth: MediaQuery.of(context).size.width - 2,
        maxHeight: 78,
        child: TextFormField(
          maxLines: 1,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
          decoration: InputDecoration(
              labelText: labelText,
              prefixIcon: new Icon(Icons.input)),
          validator: (String value) {
            return onValidator(value);
          },
          onSaved: (String value) {
            onSaved(value);
          },
        ));
  }

  List<DropdownMenuItem> _getItems() {
    List<DropdownMenuItem> items = List<DropdownMenuItem>.from([]);
    items.add(DropdownMenuItem(child: Text("北京"), value: "BJ"));
    items.add(DropdownMenuItem(child: Text("上海"), value: "SH"));
    items.add(DropdownMenuItem(child: Text("广州"), value: "GZ"));
    items.add(DropdownMenuItem(child: Text("深圳"), value: "SZ"));
    return items;
  }

  Widget _buildDropdownButtonField(BuildContext context, Function onChanged) {
    return LimitedBox(
        maxWidth: MediaQuery.of(context).size.width - 2,
        maxHeight: 78,
        child: DropdownButton(onChanged: onChanged, items: _getItems()));
  }

  Widget _buildFormRadioField(
      BuildContext context, Function onValidator, Function onSaved) {
       
    return AppBlocBuilder<SearchBloc,SearchStatus>(
      builder: (context, state) {
      var limitedBox = LimitedBox(
          maxWidth: MediaQuery.of(context).size.width - 2,
          maxHeight: 78,
          child: Row(
            children: <Widget>[
              Text('开发商'),
              Radio(
                value: 1,
                groupValue: state.type,
                onChanged: (v) {
                  SearchStatus eventState = state.copy();
                  eventState.type = v;
                  AppBlocProvider.of<SearchBloc>(context).dispatch("typeChange", eventState);
                },
              ),
              Text('服务商'),
              Radio(
                  value: 2,
                  groupValue: state.type,
                  onChanged: (v) {
                    
                    SearchStatus eventState = state.copy();
                    eventState.type = v;
                    AppBlocProvider.of<SearchBloc>(context).dispatch("typeChange", eventState);
                  })
            ],
          ));

      return limitedBox;
    });
  }
