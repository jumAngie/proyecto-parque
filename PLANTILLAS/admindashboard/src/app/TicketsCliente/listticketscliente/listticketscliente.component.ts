import { Component, ElementRef } from '@angular/core';
import { TicketsCliente } from 'src/app/Models/TicketsCliente';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';
import { ToastUtils } from 'src/app/Utilities/ToastUtils';

@Component({
  selector: 'app-listticketscliente',
  templateUrl: './listticketscliente.component.html',
  styleUrls: ['./listticketscliente.component.scss']
})

export class ListticketsclienteComponent {
  ticketscliente!: TicketsCliente[];
  filtro: string = '';
  p: number = 1;

  constructor(private service:ParqServicesService, private elementRef: ElementRef, private router:Router) { }

    ngOnInit(): void {
      this.TicketsClientesList();
    }

    TicketsClientesList(){
      this.service.getTicketsCliente()
      .subscribe((response: any) => {
        if (response.success) {
          this.ticketscliente = response.data;
        }
  
        var s = document.createElement("script");
        s.type = "text/javascript";
        s.src = "../assets/js/main.js";
        this.elementRef.nativeElement.appendChild(s);
      });
    }

    filtrarTickets(): TicketsCliente[] {
      const filtroLowerCase = this.filtro.toLowerCase();
    
      return this.ticketscliente.filter(ticketscliente => {
        const tipodeTicket = ticketscliente.tckt_Nombre.toLowerCase().includes(filtroLowerCase);
        const clienteValido = ticketscliente.clie_Nombres.toLowerCase().includes(filtroLowerCase);
        const cantidadValida = ticketscliente.ticl_Cantidad.toString().includes(this.filtro);
    
        return tipodeTicket || clienteValido || cantidadValida;
      });
    }

    GuardarId(ticketscliente: TicketsCliente) {
      localStorage.setItem('idTicketEliminar', ticketscliente.ticl_ID.toString());
    }

}