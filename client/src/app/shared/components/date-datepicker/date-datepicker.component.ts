import { Component, forwardRef, OnInit, Provider } from '@angular/core';
import { Moment } from 'moment';
import { MatDatepicker } from '@angular/material/datepicker';
import { DateAdapter, MAT_DATE_FORMATS, MAT_DATE_LOCALE } from '@angular/material/core';
import { MAT_MOMENT_DATE_ADAPTER_OPTIONS, MomentDateAdapter } from '@angular/material-moment-adapter';
import * as _moment from 'moment';
import { ControlValueAccessor, FormControl, NG_VALUE_ACCESSOR } from '@angular/forms';
import { SubdivisionListComponent } from '../../../subdivision-list/subdivision-list.component';

const moment = _moment;

const VALUE_ACCESOR: Provider = {
  provide: NG_VALUE_ACCESSOR,
  useExisting: forwardRef( () => DateDatepickerComponent),
  multi: true
}

export const MY_FORMATS = {
  parse: {
    dateInput: 'MM.YYYY',
  },
  display: {
    dateInput: 'MM.YYYY',
    monthYearLabel: 'MMM YYYY',
    dateA11yLabel: 'LL',
    monthYearA11yLabel: 'MMMM YYYY',
  },
};

@Component({
  selector: 'app-date-datepicker',
  templateUrl: './date-datepicker.component.html',
  styleUrls: ['./date-datepicker.component.scss'],
  providers: [
    {
      provide: DateAdapter,
      useClass: MomentDateAdapter,
      deps: [MAT_DATE_LOCALE, MAT_MOMENT_DATE_ADAPTER_OPTIONS]
    },

    {provide: MAT_DATE_FORMATS, useValue: MY_FORMATS},
    VALUE_ACCESOR

  ],
})
export class DateDatepickerComponent implements ControlValueAccessor{

  public date = new FormControl(moment());
  private onChange = (value: any) => {}

  constructor(
    private _adapter: DateAdapter<any>) {
    this._adapter.setLocale('ru');
  }

  writeValue(value: Date) {
      this.date.setValue(moment(value))
    }
    registerOnChange(fn: any) {
      this.onChange = fn
    }
    registerOnTouched(fn: any) {

    }
    setDisabledState?(isDisabled: boolean) {

    }

  chosenYearHandler(normalizedYear: Moment) {
    const ctrlValue = this.date.value
    ctrlValue.year(normalizedYear.year())
    this.date.setValue(ctrlValue)
    this.onChange(this.date.value.toDate().setDate(1))
  }

  chosenMonthHandler(normalizedMonth: Moment, datepicker: MatDatepicker<Moment>) {
    const ctrlValue = this.date.value
    ctrlValue.month(normalizedMonth.month())
    this.date.setValue(ctrlValue)
    datepicker.close()
    this.onChange(this.date.value.toDate().setDate(1))
  }

  chosenDateHandler() {
    this.onChange(this.date.value.toDate().setDate(1))
  }

}
