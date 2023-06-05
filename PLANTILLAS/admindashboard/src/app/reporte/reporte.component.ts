import { Component, OnInit } from '@angular/core';
import jsPDF from 'jspdf';
import 'jspdf-autotable';
import { TicketsCliente } from '../Models/TicketsCliente';
import { ViewChild } from '@angular/core';
import { ElementRef } from '@angular/core';
import { ParqServicesService } from '../ParqServices/parq-services.service';
import { Router } from '@angular/router';


@Component({
  selector: 'app-reporte',
  templateUrl: './reporte.component.html',
  styleUrls: ['./reporte.component.css']
})
export class ReporteComponent implements OnInit {
  ticketsInforme!: TicketsCliente[];
  @ViewChild('pdfViewer') pdfViewer!: ElementRef;

  constructor(
    private service: ParqServicesService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.getData();
    setTimeout(() => {
      this.generatePDF();
    }, 2000);
  }

  getData() {
    this.service.getReporte(3).subscribe((response: any) => {
      if (response.success) {
        this.ticketsInforme = response.data;
        console.log(this.ticketsInforme);
      }
    });
  }

  generatePDF(): void {
    const doc = new jsPDF();
  
    const header = (doc: any) => {
      doc.setFontSize(18);
      const pageWidth = doc.internal.pageSize.width;
      doc.setTextColor(40);
  
      // Agregar imagen
      const imgData = 'https://i.ibb.co/CwxtKsY/Fondito.png';
      doc.addImage(imgData, 'PNG', 10, 10, pageWidth - 20, 80);
  
      // Agregar título
      doc.setFont('Arial', 'normal');
      doc.text('Reporte Tickets Vendidos', 20, 100); // Adjust the position based on your needs
  
      // Agregar dirección
      doc.setFontSize(12);
      doc.text('Dirección: San Pedro Sula, Cortés', 20, 110);
  
      // Agregar fecha generada
      const currentDate = new Date();
      const generatedDate = currentDate.toLocaleDateString();
      doc.text(`Generado: ${generatedDate}`, 20, 120);
  
      // Agregar generado por
      const generatedBy = localStorage.getItem('usua_Usuario');
      doc.text(`Generado por el Usuario: ${generatedBy}`, 20, 115);
    };
  
    const footer = (doc: any) => {
      doc.setFontSize(12);
      doc.setFont('Pacifico', 'normal');
      doc.text('¡Gracias por su visita!', 85, doc.internal.pageSize.height - 10, {
        align: 'left'
      });
    };
  
    const mantenimientos: TicketsCliente[] = this.ticketsInforme;
  
    const columns = [
      { header: 'Cliente', dataKey: 'clie_Nombres' },
      { header: 'Identificación', dataKey: 'clie_DNI' },
      { header: 'Teléfono', dataKey: 'clie_Telefono' },
      { header: 'Ticket', dataKey: 'tckt_Nombre' },
      { header: 'Cantidad', dataKey: 'ticl_Cantidad' },
      { header: 'Forma de pago', dataKey: 'pago_Nombre' }
    ] as { header: string; dataKey: keyof TicketsCliente }[];
  
    doc.setFontSize(18);
    const pageWidth = doc.internal.pageSize.width;
    doc.setTextColor(40);
    doc.setTextColor(40);
  
    // Llamar a las funciones de encabezado y pie de página
    header(doc);
    footer(doc);
  
    const startY = 130;
    const rowHeight = 20;
    const columnWidth = pageWidth / columns.length;
  // Dibujar encabezado de tabla
columns.forEach((column, index) => {
  doc.setFillColor(230, 230, 230); // Light gray color (adjust the RGB values as needed)
  doc.setFont('Arial', 'bold');
  doc.rect(index * columnWidth, startY, columnWidth, rowHeight, 'F');
  doc.setTextColor(0);
  doc.setFontSize(12); // Set smaller font size
  doc.text(column.header, index * columnWidth + 5, startY + 15);
});

  
    // Dibujar contenido de la tabla
    mantenimientos.forEach((mantenimiento, rowIndex) => {
      const dataRow = columns.map((column) => mantenimiento[column.dataKey]);
      doc.setFont('Arial', 'normal');
      doc.setDrawColor(0);
      doc.setFillColor("255");
      doc.setTextColor(0);
  
      dataRow.forEach((data, columnIndex) => {
        doc.rect(columnIndex * columnWidth, startY + (rowIndex + 1) * rowHeight, columnWidth, rowHeight, 'FD');
        doc.setFontSize(10); // Set smaller font size
        doc.text(data.toString(), columnIndex * columnWidth + 5, startY + (rowIndex + 1) * rowHeight + 15);
      });
    });
  
    // Generar el PDF
    const pdfOutput = doc.output('blob');
  
    // Crear una URL a partir del blob
    const url = URL.createObjectURL(pdfOutput);
  
    // Mostrar el PDF en el visor
    this.pdfViewer.nativeElement.src = url;
  }
  
  
}
