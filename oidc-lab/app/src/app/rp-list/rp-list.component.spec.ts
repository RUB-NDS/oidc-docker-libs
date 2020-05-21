import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RpListComponent } from './rp-list.component';

describe('RpListComponent', () => {
  let component: RpListComponent;
  let fixture: ComponentFixture<RpListComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RpListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RpListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
