package vhx.macro;

import vhx.funcs.Mapper;

using vhx.iter.IterTools;

import vhx.macro.ExprTools;

import vhx.macro.ExprTools.*;

using vhx.macro.MetaTools;

import vhx.macro.MetasTools.*;


typedef SplitOptions = {

  ?className: Nil< Mapper< String, String > >,

  ?force: Nil< Bool >,

  ?isAbstractField: Nil< ( field: ToField ) -> Nil< Bool > >,

};


class SplitTools {

  public static function split( definition: ToTypeDefinition, ?options: Nil< SplitOptions > ) {

    if ( ! definition.kind.match( TDClass( _, _, _, _ ) ) ) return [ definition ];

    final options = options.or( {} );

    final isAbstractField = options.isAbstractField.turn( _ -> ( ( field ) ->

      _( field ).or( () -> SplitTools.isAbstractField( field ) )

    ), SplitTools.isAbstractField );


    final splitFields = definition.fields.iter().partition( isAbstractField );

    final abstractFields = splitFields.first;

    final concreteFields = splitFields.second;

    if ( abstractFields.length == 0 && options.force != true ) return [ definition ];


    final concreteDefinition: ToTypeDefinition = {

      pack: definition.pack,

      name: definition.name,

      doc: definition.doc,

      pos: definition.pos,

      meta: definition.meta,

      params: definition.params,

      isExtern: definition.isExtern,

      kind: definition.kind,

      fields: concreteFields,

    };

    final concreteName = options.className.or( name -> '_' + name )( definition.name );

    setHaxeName( concreteDefinition, concreteName );

    final concretePath = getTypePath( concreteDefinition );

    final concreteType = type( concretePath );


    final abstractDefinition: ToTypeDefinition = {

      pack: definition.pack,

      name: definition.name,

      doc: definition.doc,

      pos: definition.pos,

      meta: [ mForward(), mForwardStatics(), mForwardNew() ],

      params: definition.params,

      isExtern: definition.isExtern,

      kind: TDAbstract( concreteType, [ concreteType ], [ concreteType ] ),

      fields: abstractFields,

    };


    return [ abstractDefinition, concreteDefinition ];

  }


  static function getTypePath( definition: ToTypeDefinition ) {

    return tyPath( definition.name, definition.params.map( _ -> _.map( param -> tParam( param.name ) ) ) );

  }

  static function isAbstractField( field: ToField ) {

    return field.hasMeta( [ ':op', ':to', ':from' ] );

  }

}
