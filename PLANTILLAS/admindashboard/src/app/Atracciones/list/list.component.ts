import { Component, OnInit, ElementRef, AfterViewInit, OnDestroy } from '@angular/core';
import { Router } from '@angular/router';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Atracciones } from 'src/app/Models/Atracciones';
import { DataTable } from 'simple-datatables';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css']
})
export class ListAtraccionesComponent implements OnInit, AfterViewInit, OnDestroy {
  atracciones!: Atracciones[];
  dataTable: DataTable | null = null;

  constructor(
    private service: ParqServicesService,
    private router: Router,
    private elementRef: ElementRef
  ) { }

  ngOnInit(): void {
    this.service.getAtracciones()
      .subscribe((response: any) => {
        if (response.success) {
          this.atracciones = response.data;
          console.log(response.data);
        }
      });
  }

  ngAfterViewInit(): void {
    this.initializeDataTable();
  }

  ngOnDestroy(): void {
    if (this.dataTable) {
      this.dataTable.destroy();
      this.dataTable = null;
    }
  }

  initializeDataTable(): void {
    if (!this.atracciones) {
      return;
    }

    setTimeout(() => {
      const tableElement = this.elementRef.nativeElement.querySelector('.datatable');
      this.dataTable = new DataTable(tableElement);
    });
  }
}
