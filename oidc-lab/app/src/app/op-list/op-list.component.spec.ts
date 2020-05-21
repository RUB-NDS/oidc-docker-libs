import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { OpListComponent } from './op-list.component';

describe('OpListComponent', () => {
  let component: OpListComponent;
  let fixture: ComponentFixture<OpListComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ OpListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(OpListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
