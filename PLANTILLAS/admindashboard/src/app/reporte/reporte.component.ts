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
      doc.addImage(
        'https://i.ibb.co/LSWNrBH/Tooniverse.png',
        'png',
        pageWidth - 100,
        -12,
        100,
         80
      );

      // Agregar texto con más margen superior
      doc.setFontSize(30);
      doc.setFont('Pacifico', 'bold');
      doc.text('Tickets vendidos', 10, 20); // Ajustar el valor para mover el texto hacia arriba

      // Agregar subtítulo con las fechas de inicio y fin
      doc.setFontSize(16);
      doc.setFont('Arial', 'normal');
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
      { header: 'Nombre del cliente', dataKey: 'clie_Nombres' },
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

    const startY = 60;
    const rowHeight = 20;

    // Obtener el contenido de la tabla en formato adecuado
    const tableContent = mantenimientos.map((mantenimiento) =>
      columns.map((column) => mantenimiento[column.dataKey])
    );

    const footerContent = {
      text: 'Gracias'
    };

    // Agregar la primera tabla al documento PDF
    (doc as any).autoTable({
      head: [columns.map((column) => column.header)],
      body: tableContent,
      footer: footerContent,
      startY: startY,
    });

    // Agregar una segunda tabla
    const secondTableStartY = doc.table.name + 20;
    const secondTableContent = [
      ['Columna 1', 'Columna 2', 'Columna 3'],
      ['Dato 1', 'Dato 2', 'Dato 3'],
      ['Dato 4', 'Dato 5', 'Dato 6'],
      // ... Agregar más filas si es necesario
    ];

    // Establecer el estilo de la segunda tabla
    const secondTableStyles = {
      theme: 'striped', // Opciones: 'striped', 'grid', 'plain', 'css', 'inherit'
      tableLineColor: 200, // Valor entre 0 y 255
      tableLineWidth: 0.2, // Valor en puntos (por defecto: 0.2)
      styles: {
        fontSize: 12,
        font: 'helvetica', // Opciones: 'helvetica', 'times', 'courier', 'helvetica-bold', 'times-bold', 'courier-bold'
        fontStyle: 'normal', // Opciones: 'normal', 'bold', 'italic', 'bolditalic'
        cellPadding: 6, // Valor en puntos (por defecto: 5)
        minCellHeight: 15, // Valor en puntos (por defecto: 0)
      }
    };

    // Agregar la segunda tabla al documento PDF
    (doc as any).autoTable({
      head: [['Encabezado 1', 'Encabezado 2', 'Encabezado 3']],
      body: secondTableContent,
      startY: secondTableStartY,
      ...secondTableStyles
    });

    // Generar el PDF
    const pdfOutput = doc.output('blob');

    // Crear una URL a partir del blob
    const url = URL.createObjectURL(pdfOutput);

    // Mostrar el PDF en el visor
    this.pdfViewer.nativeElement.src = url;
  }
}
