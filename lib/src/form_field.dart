import 'package:date_field/src/field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A [FormField] that contains a [DateTimeField].
///
/// This is a convenience widget that wraps a [DateTimeField] widget in a
/// [FormField].
///
/// A [Form] ancestor is not required. The [Form] simply makes it easier to
/// save, reset, or validate multiple fields at once. To use without a [Form],
/// pass a [GlobalKey] to the constructor and use [GlobalKey.currentState] to
/// save or reset the form field.
class DateTimeFormField extends FormField<DateTime> {
  DateTimeFormField({
    Key? key,
    FormFieldSetter<DateTime>? onSaved,
    FormFieldValidator<DateTime>? validator,
    DateTime? initialValue,
    AutovalidateMode? autovalidateMode,
    bool enabled = true,
    TextStyle? dateTextStyle,
    DateFormat? dateFormat,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    ValueChanged<DateTime>? onDateSelected,
    InputDecoration? decoration,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    DateTimeFieldPickerMode mode = DateTimeFieldPickerMode.dateAndTime,
    SelectableDayPredicate? selectableDayPredicate
  }) : super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          builder: (FormFieldState<DateTime> field) {
            // Theme defaults are applied inside the _InputDropdown widget
            final InputDecoration _decorationWithThemeDefaults =
                decoration ?? const InputDecoration();

            final InputDecoration effectiveDecoration =
                _decorationWithThemeDefaults.copyWith(
                    errorText: field.errorText);

            void onChangedHandler(DateTime value) {
              if (onDateSelected != null) {
                onDateSelected(value);
              }
              field.didChange(value);
            }

            return DateTimeField(
              firstDate: firstDate,
              initialDate: initialDate,
              lastDate: lastDate,
              decoration: effectiveDecoration,
              initialDatePickerMode: initialDatePickerMode,
              dateFormat: dateFormat,
              onDateSelected: onChangedHandler,
              selectedDate: field.value,
              enabled: enabled,
              mode: mode,
              initialEntryMode: initialEntryMode,
              dateTextStyle: dateTextStyle,
              selectableDayPredicate: selectableDayPredicate,
            );
          },
        );

  @override
  _DateFormFieldState createState() => _DateFormFieldState();
}

class _DateFormFieldState extends FormFieldState<DateTime> {}
