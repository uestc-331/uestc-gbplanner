/****************************************************************************
** Meta object code from reading C++ file 'gbplanner_ui.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.8)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../src/exploration/gbplanner_ros/gbplanner_ui/src/gbplanner_ui.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'gbplanner_ui.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.8. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_gbplanner_ui__gbplanner_panel_t {
    QByteArrayData data[8];
    char stringdata0[163];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_gbplanner_ui__gbplanner_panel_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_gbplanner_ui__gbplanner_panel_t qt_meta_stringdata_gbplanner_ui__gbplanner_panel = {
    {
QT_MOC_LITERAL(0, 0, 29), // "gbplanner_ui::gbplanner_panel"
QT_MOC_LITERAL(1, 30, 22), // "on_start_planner_click"
QT_MOC_LITERAL(2, 53, 0), // ""
QT_MOC_LITERAL(3, 54, 21), // "on_stop_planner_click"
QT_MOC_LITERAL(4, 76, 15), // "on_homing_click"
QT_MOC_LITERAL(5, 92, 20), // "on_init_motion_click"
QT_MOC_LITERAL(6, 113, 25), // "on_plan_to_waypoint_click"
QT_MOC_LITERAL(7, 139, 23) // "on_global_planner_click"

    },
    "gbplanner_ui::gbplanner_panel\0"
    "on_start_planner_click\0\0on_stop_planner_click\0"
    "on_homing_click\0on_init_motion_click\0"
    "on_plan_to_waypoint_click\0"
    "on_global_planner_click"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_gbplanner_ui__gbplanner_panel[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,   44,    2, 0x0a /* Public */,
       3,    0,   45,    2, 0x0a /* Public */,
       4,    0,   46,    2, 0x0a /* Public */,
       5,    0,   47,    2, 0x0a /* Public */,
       6,    0,   48,    2, 0x0a /* Public */,
       7,    0,   49,    2, 0x0a /* Public */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void gbplanner_ui::gbplanner_panel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<gbplanner_panel *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->on_start_planner_click(); break;
        case 1: _t->on_stop_planner_click(); break;
        case 2: _t->on_homing_click(); break;
        case 3: _t->on_init_motion_click(); break;
        case 4: _t->on_plan_to_waypoint_click(); break;
        case 5: _t->on_global_planner_click(); break;
        default: ;
        }
    }
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject gbplanner_ui::gbplanner_panel::staticMetaObject = { {
    &rviz::Panel::staticMetaObject,
    qt_meta_stringdata_gbplanner_ui__gbplanner_panel.data,
    qt_meta_data_gbplanner_ui__gbplanner_panel,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *gbplanner_ui::gbplanner_panel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *gbplanner_ui::gbplanner_panel::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_gbplanner_ui__gbplanner_panel.stringdata0))
        return static_cast<void*>(this);
    return rviz::Panel::qt_metacast(_clname);
}

int gbplanner_ui::gbplanner_panel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = rviz::Panel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 6)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 6;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
