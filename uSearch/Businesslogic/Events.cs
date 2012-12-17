﻿using System;
using System.Collections.Generic;
using System.Web;
using System.ComponentModel;

namespace uSearch.Businesslogic {
    //Forum Event args
    public class ReIndexEventArgs : System.ComponentModel.CancelEventArgs { }
    public class IndexEventArgs : System.ComponentModel.CancelEventArgs { }

    public class Events {
        /// <summary>
        /// Calls the subscribers of a cancelable event handler,
        /// stopping at the event handler which cancels the event (if any).
        /// </summary>
        /// <typeparam name="T">Type of the event arguments.</typeparam>
        /// <param name="cancelableEvent">The event to fire.</param>
        /// <param name="sender">Sender of the event.</param>
        /// <param name="eventArgs">Event arguments.</param>
        public virtual void FireCancelableEvent<T>(EventHandler<T> cancelableEvent, object sender, T eventArgs) where T : CancelEventArgs {
            if (cancelableEvent != null) {
                foreach (Delegate invocation in cancelableEvent.GetInvocationList()) {
                    invocation.DynamicInvoke(sender, eventArgs);
                    if (eventArgs.Cancel)
                        break;
                }
            }
        }
    }
}
