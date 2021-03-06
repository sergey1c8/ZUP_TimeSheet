import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SubdivisionSelectDialogComponent } from './select-list-item-dialog';

describe('SubdivisionSelectDialogComponent', () => {
  let component: SubdivisionSelectDialogComponent;
  let fixture: ComponentFixture<SubdivisionSelectDialogComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SubdivisionSelectDialogComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SubdivisionSelectDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
