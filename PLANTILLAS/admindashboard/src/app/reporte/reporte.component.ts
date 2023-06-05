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

    const startY = 130;
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

    // Generar el PDF
    const pdfOutput = doc.output('blob');

    // Crear una URL a partir del blob
    const url = URL.createObjectURL(pdfOutput);

    // Mostrar el PDF en el visor
    this.pdfViewer.nativeElement.src = url;
  }
}
